import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import { Container } from './components';

function Router() {
  return (
    <BrowserRouter>
      <Switch>
        <Route exact path="/" component={Container} />
      </Switch>
    </BrowserRouter>
  );
}

export default Router;
