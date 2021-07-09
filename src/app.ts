import http from "http"
import { url } from "inspector"

// http.createServer(
//     function(req,res){
//         res.write("API IS Down")
//         res.end()
//     }
// ).listen(8080);

// http.createServer(
//     function (req, res) {
//         res.writeHead(
//             200, {
//             "content_type": "text/html",
//         }
//         ),
//             res.write("We are back with content type")
//         res.end()
//     }
// ).listen(8080)

http.createServer(
    function (req, res) {
        res.write(req.url)
        res.end()
        console.log(req.url)
    }
).listen(8080)