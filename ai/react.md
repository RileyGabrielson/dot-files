# React Rules and Guidelines

React-specific rules and best practices.

## Component Architecture

### React as a Templating Engine

**React is intended to be used as a templating engine, and should not be primarily used to hold state.**

React components should be focused on presentation and rendering. Business logic and state management should be handled outside of React components, typically through presenters or similar patterns.

### Presenter Pattern

**Each React component should accept a single prop, a presenter, and should respond appropriately to that state.**

Components receive a presenter object that encapsulates:
- State management (using observables or similar patterns)
- Business logic and event handlers
- Data transformations

The component's responsibility is limited to:
- Rendering the UI based on presenter state
- Calling presenter methods in response to user interactions
- Subscribing to presenter state changes

#### Example

**Presenter (business logic layer):**

```typescript
import { ObservableValue } from '@tcn-internal/hex'

interface TodoPresenterPort {
  initialTodo: string[];
  onAdd: () => void;
}

class TodoPresenter {
  private todoItems: ObservableValue<string[]>;
  private adapter: TodoPresenterPort;

  constructor(adapter: TodoPresenterPort) {
    this.adapter = adapter;
    this.todoItems = new ObservableValue([]);
  }

  addTodo() {
    this.todoItems.setValue([...this.todoItems.getValue(), 'New Todo'])
    this.adapter.onAdd();
  }

  get todoItemsBroadcast() {
    return this.todoItems.broadcast;
  }

  dispose() {
    this.todoItems.dispose();
  }
}
```

**Component (presentation layer):**

```tsx
import React from 'react'
import { useAsyncValue } from '@tcn-internal/hex'

interface TodoProps {
  presenter: TodoPresenter;
}

const Todo = ({ presenter }: TodoProps) => {
  const todoItems = useAsyncValue(presenter.todoItemsBroadcast);

  return (
    <div>
      <button onClick={() => presenter.addTodo()}>Add</button>
      <div>
        {todoItems.map(item => <p key={item}>{item}</p>)}
      </div>
    </div>
  )
}
```

#### Benefits

- **Separation of concerns**: Business logic is separate from presentation
- **Testability**: Presenters can be tested independently of React
- **Reusability**: Same presenter can be used with different UI frameworks
- **Maintainability**: Clear boundaries between layers make code easier to understand and modify
