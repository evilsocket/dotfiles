# ClangFlagsView = require './clang-flags-view'
path = require 'path'
fs = require 'fs'

module.exports =
  getClangFlags: (fileName) ->
    flags = getClangFlagsCompDB(fileName)
    if flags.length == 0
      flags = getClangFlagsDotClangComplete(fileName)
    return flags
  activate: (state) ->

getFileContents = (startFile, fileName) ->
  searchDir = path.dirname startFile
  while searchDir
    searchFilePath = path.join searchDir, fileName
    try
      searchFileStats = fs.statSync searchFilePath
      if searchFileStats.isFile()
        try
          contents = fs.readFileSync searchFilePath, 'utf8'
          return [searchDir, contents]
        catch error
          console.log "clang-flags for " + fileName + " couldn't read file " + searchFilePath
          console.log error
        return [null, null]
    parentDir = path.dirname searchDir
    break if parentDir == searchDir
    searchDir = parentDir
  return [null, null]

getClangFlagsCompDB = (fileName) ->
  [searchDir, compDBContents] = getFileContents(fileName, "compile_commands.json")
  args = []
  if compDBContents != null && compDBContents.length > 0
    compDB = JSON.parse(compDBContents)
    for config in compDB
      # We might have full paths, or we might have relative paths. Try to guess the relative path by removing the search path from the file path
      relativeName = fileName[searchDir.length+1..fileName.length]
      if fileName == config['file'] || relativeName == config['file']
        allArgs = config.command.replace(/\s+/g, " ").split(' ')
        singleArgs = []
        doubleArgs = []
        for i in [0..allArgs.length - 1]
          nextArg = allArgs[i+1]
          # work out which are standalone arguments, and which take a parameter
          singleArgs.push allArgs[i] if allArgs[i][0] == '-' and (not nextArg || nextArg[0] == '-')
          doubleArgs.push allArgs[i] + " " + nextArg if allArgs[i][0] == '-' and nextArg and (nextArg[0] != '-')
        args = singleArgs
        args.push it for it in doubleArgs when it[0..7] == '-isystem'
        args = args.concat ["-working-directory=#{searchDir}"]
        break
  return args

getClangFlagsDotClangComplete = (fileName) ->
  [searchDir, clangCompleteContents] = getFileContents(fileName, ".clang_complete")
  args = []
  if clangCompleteContents != null && clangCompleteContents.length > 0
    args = clangCompleteContents.trim().split("\n")
    args = args.concat ["-working-directory=#{searchDir}"]
  return args
