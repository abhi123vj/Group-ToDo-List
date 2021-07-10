import express, { Request, Response } from "express"
import { Todo } from "../models/user_model";

const router = express.Router();

//Post request 

router.post("/add", async (req: Request, res: Response) => {

    const { title, description } = req.body
    const dataItem = Todo.set({ title, description })
     
    await dataItem.save()
    return res.status(200).json({
        data:dataItem,
    })
})

export { router }