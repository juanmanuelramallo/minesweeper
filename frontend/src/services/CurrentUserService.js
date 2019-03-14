const keyName = "userUuid";

const getCurrentUserUuid = () => {
  return window.localStorage.getItem(keyName)
}

const setCurrentUserUuid = (uuid) => {
  window.localStorage.setItem(keyName, uuid);
}

const removeCurrentUserUuid = (uuid) => {
  window.localStorage.removeItem(keyName);
}

export {
  getCurrentUserUuid,
  removeCurrentUserUuid,
  setCurrentUserUuid,
}
