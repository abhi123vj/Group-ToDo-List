import mongoose from "mongoose"

interface TodoI{

    title : string;
    description : string;
}

interface TodoDocument extends  mongoose.Document{

    
    title : string;
    description : string;
}

const todoSchema  = new mongoose.Schema({
    title : {
        type : String,
        require : true,
    },
    description : {
        type : String,
        require : false,
    },
    
})

interface todoModelInterface extends mongoose.Model<TodoDocument>{
    
    set( x : TodoI) : TodoDocument 
    
}

todoSchema.statics.set = (x:TodoI) => {
    
    return new Todo();
}

const Todo = mongoose.model<TodoDocument,todoModelInterface>(
    "Todo",
    todoSchema
)

Todo.set({
    title:"Some title",
    description : "Some description"
})

export {Todo}