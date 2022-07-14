const http = require('http')
const express = require('express')

let app = express()

app.use('/', express.static(`${__dirname}/static`))

app.get('/', (req, res) => res.redirect(302, '/cv.xml'))

let server = http.createServer(app)

server.listen(80, () => {
    console.log('Server listening on port 80')
})