## Maborami
### About

Ma(rionette)bo(otstrap)ra(tchet)mi(mosa) is a advanced skeleton for [Mimosa](http://mimosa.io).

- [Express.IO](http://express-io.org/) ([Express-Server](http://expressjs.com/) with [Socket.IO](http://socket.io/) (Websockets))
- [Bower](http://bower.io/) (Component Handling)
- [RequireJS](http://requirejs.org/) (+CSS, +HBS)
- [Jade](http://jade-lang.com/) (Server-Template)
- [CoffeeScript](http://coffeescript.org/) (JS-Metalang)
- [LESS](http://lesscss.org/) (CSS-Metalang)
- [Bootstrap](http://getbootstrap.com/) (CSS-Framework Desktop) v3
- [Bootswatch](http://bootswatch.com/) (Themes for Bootstrap) v3
- [Ratchet](http://goratchet.com/) (CSS-Framework Mobile) v2
- [Font-Awesome](http://fontawesome.io/) (Icon-Font) v3
- [Marionette](http://marionettejs.com/) (Framework) v2 using [Backbone](http://backbonejs.org/) v1
- [Handlebars](http://handlebarsjs.com/) (Client-Templates)
- [Cocktail](https://github.com/onsi/cocktail) (Mixins for Marionette)

### Requirements & Installation

You will need Mimosa properly installed. You can find out more about it [here](http://mimosa.io/started.html).

```mimosa skel:new <project> marionette-bootstrap```

Will create a new Project in the Subfolder <project> with the already set up configuration of marionette-bootstrap.

### Optimize

1. `mimosa watch -oms`
2. [localhost:3000](http://localhost:3000)

`-oms` is shorthand for `--optimize --minify --server`. This runs all the minifiers, runs the r.js optimization, and then starts a server.  The JavaScript for the app will be both minified and concatenated.

### Packaging for Deployment

1. `mimosa build -omp`
2. `cd dist`
3. `node app.js`
4. [localhost:3000](http://localhost:3000)

`-omp` is shorthand for `--optimize --minify --package`. This command will run optimization, run all the minifiers and then package the result for deployment. The packaged result doesn't need Mimosa to run.


### Misc

Need help? You can find me at 

https://gitter.im/dbashford/mimosa

or submit an issue [here](https://github.com/Anachron/maborami/issues).

### Credits

Please look in the "About" section.