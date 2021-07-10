import mongodb from "mongodb"
import dotenv from "dotenv"


dotenv.config();

export const mongoDBConnection = async () => mongodb.connect(
    process.env.MONGODB_URL as string ,
    {
        useUnifiedTopology : true
    },
    async (error,clint)=>{

        if (error) return console.log(error);
        console.log("DB Connected!")

        const database = clint.db()
        const collection = database.collection("todos")
       let datafromMongo = await collection.find().toArray()
      console.log(datafromMongo)
   
    }
);


export const PostdatatoMOngoDB =  () => mongodb.connect(
    process.env.MONGODB_URL as string ,
    {
        useUnifiedTopology : true
    },
    async (error,clint)=>{

        if (error) return console.log(error);
        console.log("DB Connected!")

        const database = clint.db()
        const collection = database.collection("todos")
       let sentDatato = await collection.insertMany(
          [ {
               name:"abhi1",
               email:"abhi6@123vjs"
           }, {
            name:"abhi3",
            email:"abhi8@123vjs"
        }, {
            name:"abhi5",
            email:"abhi8@123vjs"
        }],
           (err,data) => {
            if (err) return console.log(err);
            else console.log(data)
           }
       )
   
    }
);
export const FinddatatoMOngoDB =  () => mongodb.connect(
    process.env.MONGODB_URL as string ,
    {
        useUnifiedTopology : true
    },
    async (error,clint)=>{

        if (error) return console.log(error);
        console.log("DB Connected!")

        const database = clint.db()
        const collection = database.collection("todos")
        const filter={
            name:"abhi2"
        }
       let sentDatato = await collection.findOne(
         filter,
           (err,data) => {
            if (err) return console.log(err);
            else console.log(data)
           }
       )
   
    }
);

export const DeldatatoMOngoDB =  () => mongodb.connect(
    process.env.MONGODB_URL as string ,
    {
        useUnifiedTopology : true
    },
    async (error,clint)=>{

        if (error) return console.log(error);
        console.log("DB Connected!")

        const database = clint.db()
        const collection = database.collection("todos")
        const filter={
            name:"abhi2"
        }
       let sentDatato = await collection.deleteOne(
         filter,
           (err,data) => {
            if (err) return console.log(err);
            else console.log(data)
           }
       )
   
    }
);

export const updatedatatoMOngoDB =  () => mongodb.connect(
    process.env.MONGODB_URL as string ,
    {
        useUnifiedTopology : true
    },
    async (error,clint)=>{

        if (error) return console.log(error);
        console.log("DB Connected!")

        const database = clint.db()
        const collection = database.collection("todos")
        const filter={
            name:"abhi1"
        }
        const update={
            name:"Abhiram S",
            email:"4bh1ram@gmail.com"
        }
       let sentDatato = await collection.update(
         filter, update,
           (err,data) => {
            if (err) return console.log(err);
            else console.log(data)
           }
       )
   
    }
);
