import React, { useState, useEffect, Component } from "react";
import { Link, useNavigate } from "react-router-dom";
import "../Loginstyle.css";
import { OverlayTrigger, Tooltip } from "react-bootstrap";
import { Error } from "./InvalidInput";


const Register = () => {
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [errMsg, setErrMsg] = useState(false);
  const [regSuccess, setRegSuccess] = useState(false);
  const [userToBeInserted, setuserToBeInserted] = useState(null);
  let navigate = useNavigate();

  const [password, setPassword] = useState("");
  const [passwordAgain, setPasswordAgain] = useState("");

  const [type, setType] = useState("password");


  const [validName, setValidName] = useState(false);
  const [validPassword, setValidPassword] = useState(false);
  const [validEmail, setValidEmail] = useState(false);
  const [passMatch, setPassMatch] = useState(false);

  const [buttonPressed, setButtonPressed] = useState(false);

  const [errors, setErrors] = useState({
    nameError: "",
    emailError: "",
    invalidName: false,
    invalidEmail: false
  });

  //creates new user
  useEffect(() => {
    const insertUser = async () => {

      try {
        await fetch("http://localhost:5000/api/users/post/", {
          method: "POST",
          headers: {
            "Content-type": "application/json",
          },
          body: JSON.stringify({
            username: userToBeInserted.username,
            password: userToBeInserted.password,
            email: userToBeInserted.email
          }),
        })
          .then((res) => res.json())
          .then((data) => {
            if (data.message === undefined) {
              console.log("INSERT:", userToBeInserted);
              setuserToBeInserted(null);
              setRegSuccess(true);
              setUsername("");
              setPassword("");
              setPasswordAgain("");
              setEmail("");
              return;
            }
            setErrMsg(true);
            let msg = data.message;
            console.log("Message: ", msg);
            if (msg.includes("email") && msg.includes("Username")) {
              var m = msg.split(",");
              setErrors({ nameError: m[0], emailError: m[1], invalidName: true, invalidEmail: true });
            }
            else {
              if (msg.includes("Username")) {
                setErrors({ nameError: msg, invalidName: true });
              }
              else if (msg.includes("email")) {
                setErrors({ emailError: msg, invalidEmail: true });
              }
            }
          });
      }
      catch (error) {
        console.log(error);
      }
    };
    if (userToBeInserted != null) insertUser();
  }, [userToBeInserted]);

  /* if (regSuccess) {
     navigate("/");
   }*/

  //password validation
  useEffect(() => {
    if (password !== passwordAgain) setPassMatch(true);
    if (password === passwordAgain) setPassMatch(false);
  }, [passwordAgain]);


  //username validation
  useEffect(() => {
    if (username.length < 5) {
      setValidName(true);
      //setErrMsg(false);
    }
    else setValidName(false);

  }, [username]);

  let passMissing = [];
  const [pm, setPm] = useState("");
  //password validation
  useEffect(() => {
    const lowerCase = /[a-z]/g;
    const upperCase = /[A-Z]/g;
    const numbers = /[1-9]/g;
    setPm("");

    if (password.length < 5 || !password.match(lowerCase) || !password.match(upperCase) || !password.match(numbers)) {
      setValidPassword(true);
      /*if (password.length < 5) {
        passMissing.push(" at least 5 characters");
      }
      if (!password.match(lowerCase)) {
        passMissing.push(" a lowercase letter");
      }
      if (!password.match(upperCase)) {
        passMissing.push(" an uppercase letter");
      }
      setPm(passMissing);
      console.log(pm);
*/
    }
    else {
      setValidPassword(false);
      console.log("ehdot täyttyy");
    }

    if (password !== passwordAgain) setPassMatch(true);
    if (password === passwordAgain) setPassMatch(false);

  }, [password]);

  //email validation
  useEffect(() => {
    const isValidEmail = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g;

    if (email.length < 5 || !email.match(isValidEmail)) {
      setValidEmail(true);
    }
    else {
      setValidEmail(false);
    }
  }, [email]);

  const handleSubmit = (event) => {
    event.preventDefault();
    setButtonPressed(true);

    setErrors({ nameError: "", emailError: "", invalidName: false, invalidEmail: false });

    setErrMsg(false);

    if (!validName && !validPassword && !validEmail && !passMatch) {
      setuserToBeInserted({ username: username, password: password, email: email });
      setButtonPressed(false);
    }
    else {
      console.log("Inputs are not valid");
    };

    console.log(validPassword);
  }
  //show password
  const showPassword = (e) => {
    if (e) {
      setType("text");
    }
    else setType("Password");
  }
  return (
    <div className="Forms">
      <h2>Register</h2>
      <div className="Container">
        <form onSubmit={(e) => handleSubmit(e)}>

          <input type="text" value={username} className={validName && buttonPressed || errors.invalidName ? "invalid" : "valid"} onChange={(e) => setUsername(e.target.value)} placeholder="Username..." />
          {validName && buttonPressed ? <Error id="invalidNameError" value="Username" text="at least 5 characters" /> : ""}
          <p data-testid="nameError">{errors.nameError}</p>


          <OverlayTrigger overlay={(<Tooltip style={{ backgroundColor: "lightgrey" }}>Password must contain<br />at least 5 characters,<br />a lowercase letter,<br />an uppercase letter and a number</Tooltip>)} placement="right">
            <input data-testid="password1" type={type} value={password} className={validPassword && buttonPressed || passMatch ? "invalid" : "valid"} onChange={(e) => setPassword(e.target.value)} placeholder="Password..." />
          </OverlayTrigger>
          {validPassword && buttonPressed ? <Error id="invalidPasswordError" value="Password" text="at least 5 characters, a lowercase letter, an uppercase letter and a number" /> : ""}


          <input data-testid="password2" type={type} value={passwordAgain} className={passMatch ? "invalid" : "valid"} onChange={(e) => setPasswordAgain(e.target.value)} placeholder="Password again..." />
          {passMatch ? <p data-testid="noMatchError">Passwords don't match</p> : ""}

          <input data-testid="checkbox" type="checkbox" onChange={(e) => showPassword(e.target.checked)} /><label>Show Password</label>
          <input type="text" value={email} className={validEmail && buttonPressed || errors.invalidEmail ? "invalid" : "valid"} onChange={(e) => setEmail(e.target.value)} placeholder="Email..." />
          {validEmail && buttonPressed ? <Error id="invalidEmailError" value="Email" /> : ""}
          <p data-testid="emailError">{errors.emailError}</p>

          <input data-testid="regBtn" type="submit" value="Register" />

        </form>
      </div>


      <div className="Container">
        <p>Already have an account? <Link to="/">Login</Link></p>
      </div>

    </div>
  )
}
export { Register }