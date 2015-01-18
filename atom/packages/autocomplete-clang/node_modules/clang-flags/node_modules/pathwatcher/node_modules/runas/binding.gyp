{
  'target_defaults': {
    'conditions': [
      ['OS=="win"', {
        'msvs_disabled_warnings': [
          4530,  # C++ exception handler used, but unwind semantics are not enabled
          4506,  # no definition for inline function
        ],
      }],
    ],
  },
  'targets': [
    {
      'target_name': 'runas',
      'sources': [
        'src/main.cc',
      ],
      'include_dirs': [
        '<!(node -e "require(\'nan\')")'
      ],
      'conditions': [
        ['OS=="win"', {
          'sources': [
            'src/runas_win.cc',
          ],
          'libraries': [
            '-lole32.lib',
            '-lshell32.lib',
          ],
        }],
        ['OS=="mac"', {
          'sources': [
            'src/runas_darwin.cc',
            'src/fork.cc',
            'src/fork.h',
          ],
          'libraries': [
            '$(SDKROOT)/System/Library/Frameworks/Security.framework',
          ],
        }],
        ['OS not in ["mac", "win"]', {
          'sources': [
            'src/runas_posix.cc',
            'src/fork.cc',
            'src/fork.h',
          ],
        }],
      ],
    }
  ]
}
