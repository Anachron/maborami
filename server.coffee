bodyParser      = require 'body-parser'       # Parses the request body
compress        = require 'compression'       # Compress served pages
express         = require 'express'           # Express + Socket.io
engines         = require 'consolidate'       # Template Engines
errorHandler    = require 'errorhandler'      # Error-Handling
favIcon         = require 'serve-favicon'     # Favicon
methodOverride  = require 'method-override'   # Override Methods
serverStatic    = require 'serve-static'      # Static File Response
socketIO        = require 'socket.io'         # WebSockets
userAgent       = require 'express-useragent' # Get Request Device

exports.startServer = (config, callback) ->

  port = process.env.PORT or config.server.port
  env = process.env.NODE_ENV or 'development';

  app = express()
  
  server = app.listen port, ->
    console.log "Express server listening on port %d in %s mode", port, env

  io = socketIO.listen(server)

  app.set 'port', port
  app.set 'views', config.server.views.path
  app.locals.basedir = config.server.views.path
  app.engine config.server.views.extension, engines[config.server.views.compileWith]
  app.set 'view engine', config.server.views.extension
  app.use favIcon(__dirname + '/public/images/desktop/favicon.ico')
  app.use bodyParser.urlencoded({extended: true})
  app.use methodOverride()
  app.use compress()
  app.use express.static(config.watch.compiledDir)
  app.use userAgent.express()

  if env == 'development'
    app.use errorHandler()

  options =
    cachebust:  if env isnt "production" then "?b=#{(new Date()).getTime()}" else ''
    optimize:   config.isOptimize ? false
    reload:     config.liveReload.enabled
    device:     null

  app.get '/', (req, res) ->
    if req.useragent.isMobile
      options.device = 'mobile'
    else if req.useragent.isBot
      options.device = 'bot'
    else #if req.useragent.isDesktop
      options.device = 'desktop'

    res.render options.device, options
    
  callback server, io
