class ServerAPI {
  String endpoint = "https://go-echo-server.onrender.com/";
  // String endpoint = "http://localhost:1323/";

  String updateLocation() {
    return endpoint + "user/upd_location";
  }
}
