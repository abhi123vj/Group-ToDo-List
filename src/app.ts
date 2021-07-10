import express,{Request,Response} from "express"
import { DeldatatoMOngoDB, FinddatatoMOngoDB, PostdatatoMOngoDB, updatedatatoMOngoDB } from "./database/data"
import { router } from "./routes/routes"

const app = express()

app.use(express.urlencoded({extended :false}))
app.use(express.json())
///PostdatatoMOngoDB()
//FinddatatoMOngoDB()
//DeldatatoMOngoDB()
updatedatatoMOngoDB()
app.use("/",router)
 
app.listen(8080,()=>{
    console.log("Server rocking 8080 and")
})