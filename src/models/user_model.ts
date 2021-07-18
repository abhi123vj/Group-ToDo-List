import mongoose from "mongoose"

interface TodoI{
    user: string;
    title : string;
    description : string;
    completed: boolean;
}

interface TodoDocument extends  mongoose.Document{

    user :string;
    title : string;
    description : string;
    completed  : boolean;
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
    completed :{
        type : Boolean,
        require : false
    },
    user :{
        type : String,
        default : "public"
    }
    
    
},
{
    timestamps:true
},
)

interface todoModelInterface extends mongoose.Model<TodoDocument>{
    
    set( x : TodoI) : TodoDocument 
    
};

todoSchema.statics.set = (x :TodoI) => {
    return new Todo(x);
};

const Todo = mongoose.model<TodoDocument,todoModelInterface>(
    "Todo",
    todoSchema
)

Todo.set({
    title:"Some title",
    description : "Some description",
    completed : false,
    user:"public"
});

export {Todo}