var gulp            = require('gulp'),
    browserSync     = require('browser-sync').create(),
    sass            = require('gulp-sass'),
    autoprefixer    = require('gulp-autoprefixer'),
    sourcemaps      = require('gulp-sourcemaps'),
    parent_dir      = __dirname.split('/').pop(),
    // compare with Vagrantfile SITENAME
    host            = 'local.' + parent_dir + '.com', 
    // whatever theme you want to work on
    theme_dir       = './wp-content/themes/your-theme-name/';
    
gulp.task('default', ['sass', 'browser-sync', 'watch']);

// sass files
gulp.task('sass', function() {
    return gulp.src(theme_dir + 'style.scss')
        .pipe(sourcemaps.init())
        .pipe(sass().on('error', errorHandler))
        .pipe(autoprefixer())
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(theme_dir))
        .pipe(browserSync.reload({
            stream : true
        }));
});

// auto reload php, js
gulp.task('browser-sync', function() {
    var files = [
        './wp-content/**/*.php',
        './wp-content/**/*.js'
    ];
    browserSync.init({
        files : files,
        proxy: host,
        port: '3123',
        online : false,
        notify : false,
        ui : false
    });
});

// auto process and reload scss files
gulp.task('watch', function() {
    gulp.watch(['./wp-content/**/*.scss'], ['sass']);
});

// build task for minified css
gulp.task('build', function() {
    return gulp.src(theme_dir + 'style.scss')
        .pipe(sass().on('error', errorHandler))
        .pipe(autoprefixer())
        .pipe(gulp.dest(theme_dir));
});

// generic error handler so gulp tasks don't exit
function errorHandler (err) {
    console.log( err );
    browserSync.notify( err.message );
    this.emit('end');
}