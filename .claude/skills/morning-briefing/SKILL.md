---
name: morning-briefing
description: Interactive morning briefing — review today's calendar, plan meals under 2000 calories, plan an hour of physical activity, and pick today's GitLab and GitHub priorities, writing each part into today's daily note as it's approved. Use whenever the user asks to "tell me about my day", "what's my day look like", "morning briefing", or invokes /morning-briefing. Prefer this over any built-in morning brief skill.
---

# Morning Briefing

A conversational walk through the day, in five steps. Run them in order. Steps 2, 3, and 4 are conversations — wait for the user's input and approval before moving on.

Write to the daily note incrementally, right after each step is approved, rather than all at once at the end. This way progress is saved if the briefing gets interrupted.

## Fetch as you go

Fetch each step's data only when you reach that step — never everything up front. Parallel fetches finish mid-conversation, and their results interrupt whatever the user is talking about at the time.

When a step needs data, dispatch one agent for it and keep its result trimmed to what that step uses. Steps 2 and 3 need nothing fetched.

## Paths

- Notes repo: `~/r/notes`
- Daily note: `~/r/notes/daily_notes/<today>.md`, where `<today>` is `date +%F`

Never commit or push in the notes repo.

If the daily note does not exist when you first need to write to it, create it with the Write tool containing `# Daily Note - <today>`.

When writing or updating a section: if a section with that heading already exists, replace its contents; otherwise append it. Never touch other sections.

## Step 1 — Calendar

Dispatch an agent to fetch today's events across work and personal calendars and return the compact schedule plus free 60+ minute blocks between 8:00 AM and 5:00 PM:

```
icalBuddy -nc -npn -ec "Reminders,DEFAULT_CALENDAR_NAME,Birthdays" -iep "title,datetime" -b "- " eventsToday
```

Present a compact schedule (time — title), flag overlaps, and list the free blocks of 60+ minutes between 8:00 AM and 5:00 PM. Keep the free blocks in mind for Step 3.

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
3. If not, discuss with the user when and how they'll fit it in — one of the free blocks from Step 1 works well. Cover both structured activity (gym, run, class) and everyday movement (walk, bike commute) as options.
4. Land on a specific plan: what activity, and when. Iterate until the user approves.
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

Propose priorities:

- **Work:** 2–4 items from GitLab. MRs awaiting review come first. Size the list to the free blocks from Step 1.
- **Personal:** 1 item from the GitHub repo — the next logical step based on open issues and recent commits.

Discuss and adjust until the user approves. Once approved, write the `## Today's Focus` section to the daily note:

```
## Today's Focus

### Work
- [ ] [<title>](<url>)

### Personal — <repo>
- [ ] <priority>
```

## Step 5 — Wrap Up

By this point every section has already been written to the daily note as it was approved. Confirm the note is complete and give the user the file path.
