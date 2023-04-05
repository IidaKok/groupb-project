import React from 'react';
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '../App.css';

const Addseries = () => {
    const [bookseries, setBookseries] = useState({
        bookseries: '',
        publisher: '',
        description: '',
        classification: '',
    });
    const navigate = useNavigate();

    const handleClick = async (e) => {
        e.preventDefault();

        // Check if all required fields have a value
        const requiredFields = [
            'bookseries',
            'publisher',
            'description',
            'classification',
        ];
        const missingFields = requiredFields.filter(
            (field) => !bookseries[field]
        );

        if (missingFields.length > 0) {
            alert(`Please fill in the following fields: ${missingFields.join(', ')}`);
            return;
        }

        try {
            await fetch('http://localhost:5000/api/bookseries/post/', {
                method: 'POST',
                headers: {
                    'Content-type': 'application/json',
                },
                body: JSON.stringify({
                    bookseries: bookseries.bookseries,
                    publisher: bookseries.publisher,
                    description: bookseries.description,
                    classification: bookseries.classification,
                }),
            })
                .then((res) => res.json())
                .then((data) => {
                    if (data.message === undefined) {
                        console.log('INSERT:', bookseries);
                        setBookseries({
                            bookseries: '',
                            publisher: '',
                            description: '',
                            classification: '',
                        });
                        return;
                    }
                });
            navigate('/userPage');
        } catch (err) {
            console.log(err);
        }
    };

    const handleChange = (e) => {
        setBookseries((prev) => ({ ...prev, [e.target.name]: e.target.value }));
    };

    const handleCancel = (e) => {
        navigate('/userPage');
    };

    return (
        <div className='add-bookseries-form'>
            <h1>Add New Series</h1>
            <input
                id='user-input'
                type='text'
                placeholder='Bookseries'
                onChange={handleChange}
                name='bookseries'
                value={bookseries.bookseries}
            />
            <input
                id='user-input'
                type='text'
                placeholder='Publisher'
                onChange={handleChange}
                name='publisher'
                value={bookseries.publisher}
            />
            <input
                id='user-input'
                type='text'
                placeholder='Description'
                onChange={handleChange}
                name='description'
                value={bookseries.description}
            />
            <input
                id='user-input'
                type='text'
                placeholder='Classification'
                onChange={handleChange}
                name='classification'
                value={bookseries.classification}
            />
            <button className='formAddBtn' onClick={handleClick}>
                Add
            </button>
            <button className='formCancelBtn' onClick={handleCancel}>
                Cancel
            </button>
        </div>
    );
};

export { Addseries };
