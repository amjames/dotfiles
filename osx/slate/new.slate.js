/* File: slate.example.js
 * Author: lunixbochs (Ryan Hileman)
 * Project: http://github.com/lunixbochs/reslate
 */
S.log('Loading Config .... ');
S.src('~/.slate/defines.js');
S.src('~/.slate/reslate/reslate.js');
// enable to see debug messages in Console.app
$.debug = true;

slate.alias('hyper', 'ctrl;alt;cmd');
slate.alias('lowper', 'ctrl;alt');

// begin config
//slate.config("modalEscapeKey","esc");
slate.configAll({
    defaultToCurrentScreen: true,
    nudgePercentOf: 'screenSize',
    resizePercentOf: 'screenSize',
    modalEscapeKey: 'esc',
    undoOps: [
        'active-snapshot',
        'chain',
        'grid',
        'layout',
        'move',
        'resize',
        'sequence',
        'shell',
        'push'
    ]
});
// bindings
slate.bindAll({
    hyper: {
        shift: {
            // edges
            h: [$('barResize', 'left',   3),
                $('center',    'left',   3, 3)],
            j: [$('barResize', 'bottom', 2),
                $('center',    'bottom', 3, 3)],
            k: [$('barResize', 'top',    2),
                $('center',    'top',    3, 3)],
            l: [$('barResize', 'right',  3),
                $('center',    'right',  3, 3)],

            // corners
            y: [$('corner', 'top-left',     3, 2),
                $('corner', 'top-left',     3, 3)],
            i: [$('corner', 'top-right',    3, 2),
                $('corner', 'top-right',    3, 3)],
            b: [$('corner', 'bottom-left',  3, 2),
                $('corner', 'bottom-left',  3, 3)],
            m: [$('corner', 'bottom-right', 3, 2),
                $('corner', 'bottom-right', 3, 3)],

            // centers
            u: [$('center', 'top'),
                $('center', 'top', 3, 3)],
            n: [$('center', 'bottom'),
                $('center', 'bottom', 3, 3)],
            'return': $('center', 'center', 3, 3)
        },
        // bars
        h: [$('barResize', 'left',  2),
            $('barResize', 'left',  1.5)],
        j: $('barResize', 'bottom', 2),
        k: $('barResize', 'top',    2),
        l: [$('barResize', 'right', 2),
            $('barResize', 'right', 1.5)],
        // corners
        y: [$('corner', 'top-left'),
            $('corner', 'top-left', 1.5)],
        i: [$('corner', 'top-right'),
            $('corner', 'top-right', 1.5)],
        b: [$('corner', 'bottom-left'),
            $('corner', 'bottom-left', 1.5)],
        m: [$('corner', 'bottom-right'),
            $('corner', 'bottom-right', 1.5)],
        // centers
        u: $('center', 'top'),
        n: $('center', 'bottom'),
        'return': $('center', 'center'),
        // throw to monitor
        '`': ['throw 0 resize',
              'throw 1 resize'],
        '1': $('toss', '0', 'resize'),
        '2': $('toss', '1', 'resize'),
        '3': $('toss', '2', 'resize'),
        // direct focus
        // utility functions
        f1: 'relaunch',
        z: 'undo',
        q: 'grid'
    },
  lowper: {
    shift:  {
      //I want to replace these with "open new window osascript hacks"
      a: $.focus('Asana'),
      c: $.focus('Messages'),
      s: $.focus('Safari'),
      t: $.focus('Terminal'),
      f: $.focus('Wunderlist'),
      e: $.focus('Airmail'),
      p: $.focus('iTunes'),
      x: $.focus('SourceTree')
    },
      '`': 'hint',
      //replace these with {if app open --> focus app;} {else--> open aopp; focus app }
      //type statements
      a: $.focus('Asana'),
      c: $.focus('Messages'),
      s: $.focus('Safari'),
      t: $.focus('Terminal'),
      f: $.focus('Wunderlist'),
      e: $.focus('Airmail'),
      p: $.focus('iTunes'),
      x: $.focus('SourceTree')
  }
});

//put this above soon
S.log('... Config LOADED!');
