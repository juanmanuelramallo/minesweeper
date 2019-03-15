import axios from "../services/AxiosService";

const user = () => {
  return axios().get("/users/current");
}

const createUser = (name) => {
  return axios().post("/users", {
    user: {
      name
    }
  });
}

const createGame = (gameOptions) => {
  return axios().post("/games", gameOptions);
}

const game = (gameId) => {
  return axios().get(`/games/${gameId}`);
}

const openCell = (openedCell, gameId) => {
  return axios().put(`/games/${gameId}`, {
    game: {
      openedCell
    }
  });
}

const flagCells = (flaggedCells, gameId) => {
  return axios().put(`/games/${gameId}`, {
    game: {
      flaggedCells
    }
  })
}

export {
  createGame,
  createUser,
  flagCells,
  game,
  openCell,
  user,
}
