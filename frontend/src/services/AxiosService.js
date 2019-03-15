import axios from "axios";
import { getCurrentUserUuid } from "./CurrentUserService";

const axiosInstance = () => axios.create({
  baseURL: process.env.REACT_APP_API_URL,
  headers: {
    'X-Minesweeper-User-Uuid': getCurrentUserUuid(),
  }
});

export default axiosInstance;
