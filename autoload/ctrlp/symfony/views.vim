if exists('g:loaded_ctrlp_symfony_views') && g:loaded_ctrlp_symfony_views
    finish
endif
let g:loaded_ctrlp_symfony_views = 1

let s:views_var = {
\  'init':   'ctrlp#symfony#views#init()',
\  'accept': 'ctrlp#symfony#views#accept',
\  'lname':  'Symfony views',
\  'sname':  'sf views',
\  'type':   'path',
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
    let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:views_var)
else
    let g:ctrlp_ext_vars = [s:views_var]
endif

fun! ctrlp#symfony#views#find()
    let paths = [
        \'app/Resources/views/**',
        \'src/**/Resources/views/**',
    \]

    return ctrlp#symfony#find(paths, '[^.]*.*')
endf

fun! ctrlp#symfony#views#init()
    let results = ctrlp#symfony#views#find()

    return ctrlp#symfony#substitute(results, '^\(src/\|app/Resources/\)')
endf

fun! ctrlp#symfony#views#accept(mode, str)
    let root = ctrlp#symfony#get_root()

    if filereadable(printf('%s/app/Resources/%s', root, a:str))
        call ctrlp#acceptfile(a:mode, printf('%s/app/Resources/%s', root, a:str))
    else
        call ctrlp#acceptfile(a:mode, printf('%s/src/%s', root, a:str))
    endif
endf

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
fun! ctrlp#symfony#views#id()
    return s:id
endf