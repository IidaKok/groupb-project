import React from "react";
import { Link, useNavigate } from "react-router-dom";
import "../App.css";

export const NavBar = (props) => {

    const { userLogged } = props;

    const navigate = useNavigate();

    const logOut = () => {
        fetch('http://localhost:5000/logout', {
            method: 'POST',
            credentials: 'include'
        })
            .then(response => {
                if (response.ok) {
                    userLogged(false);
                    document.cookie = "cookieName=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
                    navigate("/");
                } else {
                    console.error(response.message);
                }
            })
            .catch(error => {
                console.error(error);
            });
    }
    return (
        <div className="navbar">
            <Link to="/">Home</Link>
            <Link to="/series">Series</Link>
            <Link to="/userPage">UserPage</Link>
            <button onClick={() => logOut()}>Log out</button>
        </div>
    )
}