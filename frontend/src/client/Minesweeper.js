import axios from "../services/AxiosService";

const init = () => {
  return axios.get("/users/current");
}

const createUser = (name) => {
  return axios.post("/users", {
    user: {
      name
    }
  })
}

const createGame = (gameOptions) => {
  return axios.post("/games", gameOptions)
}

const openCell = (game, openedCell) => {
  return axios.put(`/games/${game.id}`, {
    game: {
      openedCell
    }
  })
}

export {
  init,
  createUser,
  createGame,
  openCell
}
