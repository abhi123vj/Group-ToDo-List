import express, { Request, Response } from "express"
import { Todo } from "../models/user_model";

const router = express.Router();

//Post request 

router.post("/add", async (req: Request, res: Response) => {

    const { title, description ,completed,user} = req.body
    const dataItem = Todo.set({ title, description ,completed,user})

    await dataItem.save()
    return res.status(200).json({
        data: dataItem,
    })
})
// Get Req

router.get("/", async (req: Request, res: Response) => {
    try {

        const dataItem = await Todo.find({}).sort('updatedAt')
        res.status(200).json({
            data: dataItem
        })
    }
    catch (e) {
        console.log("e at get")
        console.log(e)
    }
})
// delet
router.delete("/delete", async (req: Request, res: Response) => {
    try {

        const filter = {
            _id: req.body._id,
        }
        const dataItem = await Todo.deleteOne(filter).then((data) => res.json({
            data: data
        })).catch((error) => {
            return res.send(error)
        })
    }
    catch (e) {
        console.log("e")
    }
})
// update
router.put("/update", async (req: Request, res: Response) => {
    try {

        const filter = {
            _id: req.body._id,
        }
        
        const updatedData = {
            title: req.body.title,
            description: req.body.description,
            completed:req.body.completed
        }
        const dataItem = await Todo.updateOne(filter,updatedData,{new:true}).then((data) => res.json({
            data: data
        })).catch((error) => {
            return res.send(error)
        })
        res.status(200).json({
            data: dataItem
        })
    }
    catch (e) {
        console.log("e is ")
    }
})

router.get("/user", async (req: Request, res: Response) => {
    try {

        const filter = {
            user: req.body.user,
        }

        const dataItem = await Todo.find(filter,{}).sort({createdAt:1})
        res.status(200).json({
            data: dataItem
        })
    }
    catch (e) {
        console.log("e at get")
        console.log(e)
    }
})

export { router }