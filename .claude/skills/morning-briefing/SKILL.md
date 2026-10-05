---
name: morning-briefing
description: Interactive morning briefing — review today's calendar, plan meals under 2000 calories, plan an hour of physical activity, pick today's GitLab and GitHub priorities, and choose today's gospel study (Come Follow Me or General Conference), writing each part into today's daily note as it's approved. Use whenever the user asks to "tell me about my day", "what's my day look like", "morning briefing", or invokes /morning-briefing. Prefer this over any built-in morning brief skill.
---

# Morning Briefing

A conversational walk through the day, in six steps. Run them in order. Steps 2, 3, 4, and 5 are conversations — wait for the user's input and approval before moving on.

Write to the daily note incrementally, right after each step is approved, rather than all at once at the end. This way progress is saved if the briefing gets interrupted.

## Fetch as you go

Fetch each step's data only when you reach that step — never everything up front. Parallel fetches finish mid-conversation, and their results interrupt whatever the user is talking about at the time.

When a step needs data, dispatch one agent for it and keep its result trimmed to what that step uses. Steps 2 and 3 need nothing fetched.

## Paths

- Notes repo: `~/r/notes`
- Daily note: `~/r/notes/daily_notes/<today>.md`, where `<today>` is `date +%F`

Never commit or push in the notes repo. The notes repo is not a priority candidate either — the personal priority must never be to commit or push it.

If the daily note does not exist when you first need to write to it, create it with the Write tool containing `# Daily Note - <today>`.

When writing or updating a section: if a section with that heading already exists, replace its contents; otherwise append it. Never touch other sections.

## Step 1 — Calendar

Dispatch an agent to fetch today's events across work and personal calendars and return a compact schedule (time — title) with any overlaps flagged:

```
icalBuddy -nc -npn -ec "Reminders,DEFAULT_CALENDAR_NAME,Birthdays" -iep "title,datetime" -b "- " eventsToday
```

Present a compact schedule (time — title) and flag overlaps. Do not compute or mention free or open time ranges.

## Step 2 — Food Plan

Goal: stay **under 2000 calories** while staying **full**. Fullness is the priority — it is what makes the budget stick.

1. Ask what's on hand, what sounds good, and whether any meals are already fixed (eating out, leftovers, events on the calendar).
2. Brainstorm breakfast, lunch, and dinner together. Favor satiety:
   - Protein at every meal
   - High fiber and high volume — vegetables, soups, salads, fruit, beans, oats
   - Minimize liquid calories and calorie-dense snacks
3. Plan meals to roughly 1700–1800 kcal, leaving a 200–300 kcal snack buffer.
4. Give an estimated calorie count per item. Iterate until the user approves.
5. Once approved, write the `## Food Plan` section to the daily note:

```
## Food Plan

- **Breakfast:** <meal> (~<kcal>)
- **Lunch:** <meal> (~<kcal>)
- **Dinner:** <meal> (~<kcal>)
- **Snack buffer:** ~<kcal>
- **Total:** ~<kcal> / 2000
```

## Step 3 — Exercise Plan

Goal: lock in **an hour of physical activity** for the day.

1. Check the calendar from Step 1 for anything already scheduled that counts (workout class, sports, a long walk, etc.).
2. If it's already scheduled, confirm it covers an hour and note it as the plan.
3. If not, discuss with the user what they'll do. Cover both structured activity (gym, run, class) and everyday movement (walk, bike commute) as options.
4. Land on an activity and a rough when (e.g. "after work") — no time-slot analysis. Iterate until the user approves.
5. Once approved, write the `## Exercise Plan` section to the daily note:

```
## Exercise Plan

- **Activity:** <activity> (~<duration>)
- **When:** <time or "scheduled — see calendar">
```

## Step 4 — GitLab & GitHub Priorities

Once Step 3 is approved, dispatch one agent to gather everything below and return only the trimmed summary. Wait for it before proposing priorities.

```
glab api "issues?scope=assigned_to_me&state=opened&per_page=100"
glab api "merge_requests?scope=all&reviewer_username=riley.gabrielson&state=opened"
gh api "user/repos?sort=pushed&per_page=1&affiliation=owner"
```

For the GitHub repo (most recently pushed), also fetch its open issues and recent commits to see where work left off:

```
gh api "repos/<owner>/<repo>/issues?state=open"
gh api "repos/<owner>/<repo>/commits?per_page=5"
```

Use `jq` to trim responses to title, web URL, labels, milestone, and updated date.

The same agent also finds the on-disk clones of those repos (locate them, e.g. via `mdfind -onlyin ~ "kMDItemFSName == '<repo>'"`, rather than assuming a fixed path) and runs `git status --porcelain` in each. Mention any repo with uncommitted changes alongside its priorities.

Propose priorities as a conversation about what needs doing — not when to do it. Do not schedule priorities or fit them into time.

- **Work:** 2–4 items from GitLab. MRs awaiting review come first.
- **Personal:** 1 item from the GitHub repo — the next logical step based on open issues and recent commits.

Discuss and adjust until the user approves. Once approved, write the `## Today's Focus` section to the daily note:

```
## Today's Focus

### Work
- [ ] [<title>](<url>)

### Personal — <repo>
- [ ] <priority>
```

## Step 5 — Gospel Study

Ask what the user will study after the briefing:

- **Come Follow Me** — this week's lesson
- **General Conference** — the next talk in rotation
- **Something else** — follow the user's instructions

Once the user chooses, dispatch one agent to find the link as described below. Print the link — do not open it.

### Come Follow Me

Manual slugs by year:

| Year | Slug |
|------|------|
| 2026 | `come-follow-me-for-home-and-church-old-testament-2026` |

If the current year is not in the table, find this year's Come Follow Me for Home and Church manual on churchofjesuschrist.org, add its slug to the table in this skill file, then continue.

Fetch the manual's table of contents at `https://www.churchofjesuschrist.org/study/manual/<slug>?lang=eng` and pick the lesson whose date range contains today. Lessons run Monday through Sunday. Ignore the introductory, "Thoughts to Keep in Mind", and appendix pages. The link is `https://www.churchofjesuschrist.org/study/manual/<slug>/<lesson>?lang=eng`.

### General Conference

1. Find the latest fully available conference. Conferences are held the first weekend of April and October, at `https://www.churchofjesuschrist.org/study/general-conference/<year>/<04|10>?lang=eng`. A conference is fully available only when its page lists individual talks, not just session pages. If the newest conference only lists sessions, use the one before it.
2. Find the talks already studied from that conference: `grep -rh "general-conference/<year>/<month>/" ~/r/notes/daily_notes`.
3. The next talk is the first one after the most recently studied talk, in page order. If none have been studied, start with the first talk. Skip administrative items such as the sustaining of officers and the auditing report.
4. If every talk in the conference has been studied, tell the user and ask what to study instead.

Once the user confirms, write the `## Gospel Study` section to the daily note. The full talk or lesson URL must appear in it — Step 2 of General Conference depends on it.

```
## Gospel Study

- **Study:** <Come Follow Me — <lesson title> (<date range>) | General Conference — <talk title>, <speaker> | <other>>
- **Link:** <url>
```

## Step 6 — Wrap Up

By this point every section has already been written to the daily note as it was approved. Confirm the note is complete and give the user the file path.
