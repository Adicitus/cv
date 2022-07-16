const http = require('http')
const fs = require('fs')
const express = require('express')

let app = express()

app.use('/', express.static(`${__dirname}/static`))

app.get('/', (req, res) => {
    fs.readFile(`${__dirname}/static/cv.xml`, (err, data) => {
        if (err) {
            res.status(500)
            res.end()
            return
        }
        
        res.status(200)
        res.setHeader('Content-Type', 'text/xml')
        res.setHeader('charset', 'utf-8')
        res.end(data)
    })
})

let server = http.createServer(app)

server.listen(80, () => {
    console.log('Server listening on port 80')
})