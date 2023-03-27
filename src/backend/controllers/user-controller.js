const HttpError = require("../models/http-error");
const db = require("../db");

//creates new user
const createUser = async (req, res, next) => {

    const iduser = req.body.iduser;
    const username = req.body.username;
    const password = req.body.password;
    const email = req.body.email;
    let error = [];
    let msg1 = "Username is already taken";
    let msg2 = "The email address is already subscribed. Please try to use another one or simply Log in";
    

    try {
        //checks if the username is taken
        const userByName = await db.pool.query("select * from user where username = '" + username + "'");
        const usern = userByName.find(u => {
            return u.username === username;
        });
        //checks if the email is taken
        const userByEmail = await db.pool.query("select * from user where email = '" + email + "'");
        const usere = userByEmail.find(u => {
            return u.email === email;
        });


        if (!usern && !usere) {
            //sends the user's information to the database
            const response = db.pool.query("INSERT INTO user (iduser, username, password, email) VALUES (" + iduser + ",'" + username + "','" + password + "','" + email + "')");
            res.send(response);


            console.log("This was sent");
            console.log(iduser, username, password, email);
        }
        else { 
            //if username or email is taken returns error
            if (usern) {
                error.push(msg1);
            }
            if (usere) {
                error.push(msg2);
            }
            return next(new HttpError(error, 400));
        }
    }
    catch (err) {
        throw err;
    }

}
//gets all users from the database
const getAllUsers = async (req, res, next) => {
    try {
        const result = await db.pool.query("select * from user");
        res.send(result);

        //if no users are found, error is returned
        if (!result) {
            return next(new HttpError("Can't find users", 404));
        }
    }
    catch (err) {
        throw err;
    }
}


//gets user from the database based on username and password
const getUserByNameAndPassword = async (req, res, next) => {
    try {
        const usernam = req.params.username;
        const password = req.params.password;
        const result = await db.pool.query("select * from user");

        //checks if the user exists
        const user = result.find(u => {
            return u.username === usernam && u.password === password;
        });

        //if user doesn't exists, error is returned
        if (!user) {
            return next(new HttpError("Can't find user", 404));
        }
        res.json(basicDetails(user));
    }
    catch (err) {
        throw err;
    }
}
function basicDetails(user) {
    const { iduser, username, password, email } = user;
    return { iduser, username, password, email };
}

exports.getAllUsers = getAllUsers;
exports.getUserByNameAndPassword = getUserByNameAndPassword;
exports.createUser = createUser;
