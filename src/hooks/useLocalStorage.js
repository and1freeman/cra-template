import { useState, useEffect } from 'react';
import Maybe from 'folktale/maybe';

const setItem = (key, value) =>
  window.localStorage.setItem(key, JSON.stringify(value));

const useLocalStorage = (key, initialValue) => {
  const [value, setValue] = useState(() => {
    const state = Maybe.fromNullable(window.localStorage.getItem(key))
      .map(JSON.parse)
      .getOrElse(initialValue);

    return state;
  });

  useEffect(() => {
    console.log('save', key, value);
    setItem(key, value);
  }, [key, value]);

  return [value, setValue];
};

export default useLocalStorage;
