#Gulpfile
gulp      = require 'gulp'

#Gulp plugins
connect   = require 'gulp-connect'
bower     = require 'gulp-bower-files'
inject    = require 'gulp-inject'
classify  = require 'gulp-ng-classify'
coffee    = require 'gulp-coffee'
sass      = require 'gulp-sass'
jade      = require 'gulp-jade'

#Use Wiredep directly
wiredep   = require 'wiredep'
  .stream

#Use karma directly
karma     = require 'karma'
  .server

gulp.task 'serve', ->
  connect.server
    root: 'app/public',
    livereload: true

gulp.task 'coffee', ->
  gulp.src 'app/src/scripts/**/*.coffee'
    .pipe classify()
    .pipe coffee()
    .pipe gulp.dest 'app/public/js'
    .pipe connect.reload()

gulp.task 'coffee_test', ->
  gulp.src 'app/specs/**/*.coffee'
    .pipe coffee()
    .pipe gulp.dest 'app/specs/js'
    .pipe connect.reload()

gulp.task 'sass', ->
  gulp.src 'app/src/styles/**/*.sass'
    .pipe sass(
      indentedSyntax: true,
      errLogToConsole: true
    )
    .pipe gulp.dest 'app/public/css'
    .pipe connect.reload()

gulp.task 'jade', ['jade-index','jade-views']

gulp.task 'jade-index', ->
  gulp.src 'app/src/index.jade'
    .pipe jade(
      pretty: true
    )
    .pipe wiredep( ignorePath: "../public/"  )
    .pipe inject gulp.src('app/public/js/**/*.js'), ignorePath: "/app/public/"
    .pipe inject gulp.src('app/public/css/**/*.css'), ignorePath: "/app/public/"
    .pipe gulp.dest 'app/public'
    .pipe connect.reload()

gulp.task 'jade-views', ->
  gulp.src 'app/src/views/*.jade'
    .pipe jade(
     pretty: true
    )
    .pipe gulp.dest 'app/public/views'
    .pipe connect.reload()

gulp.task 'watch', ->
  gulp.watch 'app/src/scripts/**/*.coffee', ['coffee', 'test']
  gulp.watch 'app/specs/**/*.coffee', ['coffee_test','test']
  gulp.watch 'app/src/styles/**/*.sass', ['sass']
  gulp.watch 'app/src/views/**/*.jade', ['jade-views']
  gulp.watch 'app/src/index.jade', ['jade-index']

gulp.task 'test', ['coffee_test'], (done) ->
  karma.start {
    configFile: __dirname + '/karma.conf.js',
    singleRun: true
  }, done

gulp.task 'tdd', ['coffee_test'], (done) ->
  karma.start {
    configFile: __dirname + '/karma.conf.js'
  }, done

gulp.task 'default', ['coffee', 'coffee_test','sass', 'jade', 'test', 'serve', 'watch']
