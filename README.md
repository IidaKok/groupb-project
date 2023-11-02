# Software Engineering 2 Project

## Project Description:
A web application intended for collectors of old books, where you can easily view books and magazines belonging to a certain series. The application can also be used to manage your own collection of an already existing series and the books and magazines that belong to it. Moreover, users have the capability to add entirely new series, books, and magazines to their collection.

## Project Requirements:
- Custom browser-based client (frontend)
- Custom backend
- Database (SQL, MongoDB, etc.)
- REST API with endpoints and functionalities approved during inspections.

## Usage Instructions:
1. Clone the code
2. Install MariaDB and add the database using the script found in the directory ~/groupb-project/MySQL/ohjtuot2updateEnglish.sql
3. Modify the database connection settings in the file: ~/groupb-project/src/backend/db.js if needed
4. Install the necessary packages:
     - ~/groupb-project -> `npm install`
     - ~/groupb-project/src/backend -> `npm install -g nodemon`
5. Start the backend in the location: ~/groupb-project/src/backend -> `nodemon App.js`
6. [Open in a web browser](https://iidakok.github.io/groupb-project/)

## Known Issues:
Currently, the password recovery feature implemented via Nodemailer is non-functional.
