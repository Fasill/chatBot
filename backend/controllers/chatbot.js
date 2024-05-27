import 'dotenv/config';
import { GoogleGenerativeAI } from "@google/generative-ai";

const genAI = new GoogleGenerativeAI(process.env.API_KEY);

export const chat = async (req, res) => {

    const { prompt } = req.body;

    const model = genAI.getGenerativeModel({ model: "gemini-pro" });

    try{
      
      const result = await model.generateContent(prompt);
      const response = result.response;
      const text = response.text();
      res.status(200).send({response:text})


    }catch(e){
      res.states(500).send({error:"internal server error"})
    }
};
