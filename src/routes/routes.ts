import express, { Request,Response }  from "express"

const router = express.Router();

router.get("/",(req:Request,res:Response)=>{
    res.json({
        message:"API IS ROCKING",
    })
})
router.post("/",(req:Request,res:Response)=>{
  
    const {name,email} =req.body
    console.log(name)
    console.log(email)


    res.json({
        user: {name,email},
    })
})
router.get("/about",(req:Request,res:Response)=>{
    res.json({
        message:"this is about page",
    })
})
router.get("/profile",(req:Request,res:Response)=>{
    res.json({
        message:"this is profile page",
    })
})

export {router}