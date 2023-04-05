import React from 'react'
import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import "../App.css";


const Addbook = (props) => {
    const [bookcopy, setBookcopy] = useState(null);
    const navigate = useNavigate();
    const { user } = props;
    const [shelf, setShelf] = useState([]);

    useEffect(() => {
        const fetchBooks = async () => {
            let response = await fetch("http://localhost:5000/api/bookshelf/" + user.iduser);
            if (response.ok) {
                let c = await response.json();
                setShelf(c);
            }
        }
        fetchBooks();
    }, [user.iduser]);

    const handleChange = (e) => {
        setBookcopy(prev => ({ ...prev, [e.target.name]: e.target.value }))
    };


    const handleClick = async (e) => {
        e.preventDefault();

        // Check if all required fields have a value
        const requiredFields = [
            "bookname",
            "edition",
            "publicationyear",
            "purchaseprice",
            "purchasedate",
            "condition",
            "description",
            "soldprice",
        ];
        const missingFields = requiredFields.filter(
            (field) => !bookcopy[field]
        );
        if (missingFields.length > 0) {
            alert(
                `Please fill in the following fields: ${missingFields.join(", ")}`
            );
            return;
        }

        // Validate input
        const errors = {};

        if (!/^\d+$/.test(bookcopy.edition) || bookcopy.edition.length > 9) {
            errors.edition = "Edition should be a number with no more than 4 digits";
        }


        if (
            !/^\d{4}$/.test(bookcopy.publicationyear) ||
            bookcopy.publicationyear < 0 ||
            bookcopy.publicationyear > new Date().getFullYear()
        ) {
            errors.publicationyear =
                "Publication year should be an accurate 4-digit number";
        }

        if (bookcopy.purchasedate > new Date().toISOString().split("T")[0]) {
            errors.purchasedate = "Purchase date should not be in the future";
        }

        if (bookcopy.solddate && bookcopy.solddate > new Date().toISOString().split("T")[0]) {
            errors.solddate = "Sold date should not be in the future";
        }

        if (Object.keys(errors).length > 0) {
            const message = Object.entries(errors)
                .map(([field, error]) => `${field}: ${error}`)
                .join("\n");
            alert(message);
            return;
        }

        try {
            await fetch("http://localhost:5000/api/bookcopy/post/", {
                method: "POST",
                headers: {
                    "Content-type": "application/json",
                },
                body: JSON.stringify({
                    idbookcopy: bookcopy.idbookname,
                    bookname: bookcopy.bookname,
                    edition: parseInt(bookcopy.edition),
                    publicationyear: parseInt(bookcopy.publicationyear),
                    purchaseprice: parseFloat(bookcopy.purchaseprice),
                    purchasedate: bookcopy.purchasedate,
                    condition: parseInt(bookcopy.condition),
                    description: bookcopy.description,
                    solddate: bookcopy.solddate,
                    soldprice: parseFloat(bookcopy.soldprice),
                    idbookshelf: shelf.idbookshelf,
                }),
            })
                .then((res) => res.json())
                .then((data) => {
                    if (data.message === undefined) {
                        console.log("INSERT:", bookcopy);
                        setBookcopy(null);
                        navigate("/userPage");
                    }
                });
        } catch (err) {
            console.log(err);
        }
    };
    const handleCancel = (e) => {
        navigate("/userPage")
    }

    return (
        <div className="add-bookcopy-form">
            <h1>Add New Book</h1>
            <input id="user-input" type="text" placeholder="bookname" onChange={handleChange} name="bookname" />
            <input id="user-input" type="number" placeholder="edition" onChange={handleChange} name="edition" onKeyPress={(event) => {
                if (!/[0-9]/.test(event.key)) {
                    event.preventDefault();
                }
            }} />
            <input id="user-input" type="number" placeholder="publicationyear" onChange={handleChange} name="publicationyear" onKeyPress={(event) => {
                if (!/[0-9]/.test(event.key)) {
                    event.preventDefault();
                }
            }} />
            <input id="user-input" type="number" placeholder="purchaseprice" onChange={handleChange} name="purchaseprice" onKeyPress={(event) => {
                if (!/[0-9]/.test(event.key)) {
                    event.preventDefault();
                }
            }} />
            <select id="user-input" onChange={handleChange} name="condition">
                <option value="">Select book condition</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
            <input id="user-input" type="text" placeholder="description" onChange={handleChange} name="description" />
            <input id="user-input" type="number" placeholder="soldprice" onChange={handleChange} name="soldprice" onKeyPress={(event) => {
                if (!/[0-9]/.test(event.key)) {
                    event.preventDefault();
                }
            }} />
            <p>Purchasedate</p>
            <input id="user-input" type="date" placeholder="purchasedate" onChange={handleChange} name="purchasedate" />
            <p>Solddate</p>
            <input id="user-input" type="date" placeholder="solddate" onChange={handleChange} name="solddate" />
            <button className="formAddBtn" onClick={handleClick}>Add</button>
            <button className="formCancelBtn" onClick={handleCancel}>Cancel</button>
        </div>
    );
}

export { Addbook }