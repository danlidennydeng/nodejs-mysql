# NodeJs app with MySQL Database

A simple nodejs app connected with mySQL database.

## Getting Started

1. Clone the repo
```bash
git clone https://github.com/verma-kunal/nodejs-mysql.git
cd nodejs-mysql
```
2. Create a `.env` file in root directory and add the environment variables:
```bash
DB_HOST="localhost"
DB_USER="root" # default mysql user
DB_PASS=""
DB_NAME=""
TABLE_NAME=""
PORT=3000
```
> Make sure to create the database and the corresponding table in your mySQL database.
3. Initialize and start the development server:
```bash
npm install
npm run dev
```
![running app](https://github.com/user-attachments/assets/d882c2ec-2539-49eb-990a-3b0669af26b6)

==========================================================================================

1. make sure .gitignore **/.terraform/

2. terraform does not show error messages. create a customized log file.

3. seed the database after each terraform apply

4. terraform is not 100% as exactly as the tutorial. However, it is based on suggestions from chatGPT to compliant to practical industry standard.

5. ubuntu@ip-172-31-28-137:~/nodejs-mysql$ node -v
v20.20.1
ubuntu@ip-172-31-28-137:~/nodejs-mysql$ exit
logout
Connection to 54.152.170.174 closed.
(base) ➜  terraform git:(main) ✗ node -v                                              
v20.11.1
