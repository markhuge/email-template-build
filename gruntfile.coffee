module.exports = (grunt) ->
  grunt.initConfig
    inlinecss:
      compile:
        files: [
          expand: true
          cwd: 'build/'
          src: '**/*.html'
          dest: 'pre/'
        ]

    htmlmin:
      dist:
        options:
          removeComments: true
          removeCommentsFromCDATA: true
          collapseWhitespace: true
        files: [
          expand: true
          cwd: 'pre/'
          src: '**/*.html'
          dest: 'dist/'
        ]
    
    jade:
      html:
        options:
          pretty: true
        files: [
          expand: true
          cwd: 'src/jade/'
          src: ['**/**/*.jade']
          dest: 'build/'
          ext: '.html'
        ]

    compass:
      build:
        options:
          sassDir: 'src/sass/'
          cssDir: 'build/css/'

    watch:
      options:
        livereload: true
      all:
        files: ['src/**']
        tasks: ['build']

    clean:
      all: ['build/','dist/', 'pre/']

    connect:
      server:
        options:
          port: 8888
          base: 'dist/'


    handlebars:
      options:
        node: true
        namespace: 'template'
        processName: (filePath) ->
          filePath.replace('dist/','').replace('.html','')

      compile:
        files: 'dist/templates.js': 'dist/*.html'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-handlebars'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-htmlmin'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-inline-css'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-mailgun'
  

  grunt.registerTask 'default', ['clean','jade','compass','inlinecss', 'connect', 'watch']
  grunt.registerTask 'build', ['clean','jade','compass','inlinecss', 'htmlmin', 'handlebars']
  


