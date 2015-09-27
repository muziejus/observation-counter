# observation-counter

`Novel Observer`, as the frontend calls this app, is a webapp that builds up a
database of books and lets one count instances of whatever (placenames,
pronouns, allusions to Homer) on a sample number of pages and make estimates
about the number of instance of whatever there are in the novel as a whole.

It is built on top of [Sinatra](http://sinatrarb.com), and the database ORM is
[DataMapper](http://www.datamapper.org). It uses the
[GoogleBooks](https://github.com/zeantsoi/GoogleBooks) gem to get book metadata
from user-inputted ISBN numbers. Because the templating is based on the [Franks
Famous](https://github.com/kripy/franks-famous) Sinatra template, it is
[Heroku](http://www.heroku.com)-ready. Another result of that template is that
it uses [Mustache](https://github.com/mustache/mustache) and the
[Sinatra-Assetpack](https://github.com/rstacruz/sinatra-assetpack). I removed
the Franks Famous support for compass and modernizr and added support for
[Bootstrap](http://getbootstrap.com), which I find easier to work with.
Finally, the charts are made using two extensions of
[Chart.js](http://chartjs.org), namely
[Chart.js-ErrorBars](https://github.com/CAYdenberg/Chart.js-ErrorBars) for the
bar graphs and [Chart.Scatter](https://github.com/dima117/Chart.Scatter) for
the scatter graphs.

In development mode, it makes use of a local sqlite database, but on Heroku it uses a postgres database.
