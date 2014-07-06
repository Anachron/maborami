compress        = require 'compression'     # Compress served pages
eio             = require 'express.io'      # Express + Socket.io
engines         = require 'consolidate'     # Template Engines
instant         = require 'instant'         # Live-Reload
errorHandler    = require 'errorhandler'    # Error-Handling
favIcon         = require 'serve-favicon'   # Favicon
methodOverride  = require 'method-override' # Override Methods

exports.startServer = (config, callback) ->

  port = process.env.PORT or config.server.port

  app = eio()
  app.http().io()
  
  server = app.listen port, ->
    console.log "Express server listening on port %d in %s mode", server.address().port, app.settings.env

  app.configure ->
    app.set 'port', port
    app.set 'views', config.server.views.path
    app.locals.basedir = config.server.views.path
    app.engine config.server.views.extension, engines[config.server.views.compileWith]
    app.set 'view engine', config.server.views.extension
    app.use favIcon(__dirname + '/public/images/desktop/favicon.ico')
    app.use eio.urlencoded()
    app.use methodOverride()
    app.use compress()
    app.use config.server.base, app.router
    #app.use eio.static(config.watch.compiledDir)
    app.use instant(config.watch.compiledDir)

  app.configure 'development', ->
    app.use errorHandler()

  options =
    cachebust:  if process.env.NODE_ENV isnt "production" then "?b=#{(new Date()).getTime()}" else ''
    optimize:   config.isOptimize ? false
    reload:     config.liveReload.enabled

  app.get '/', (req, res) ->
    req.device = 'desktop'
    options.device = req.device
    switch options.device
      when 'phone'
        res.render 'mobile', options
      else
        res.render 'desktop', options
