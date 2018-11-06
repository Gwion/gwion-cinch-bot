# Strip escape codes/sequences [$1: input, $2: target variable]
function strip_escape_codes() {
    local input="${1//\"/\\\"}" output="" i char within_code=0
    for ((i=0; i < ${#input}; ++i)); do
        char="${input:i:1}"                     # get current character
        if (( ${within_code} == 1 )); then      # if we're currently within an escape code, check if end of
            case "${char}" in                   # code is reached, i.e. if current character is a letter
                [a-zA-Z]) within_code=0 ;;      # we're no longer within an escape code
            esac
            continue
        fi
        if [[ "${char}" == $'\e' ]]; then       # if current character is '\e', we've reached an escape code
            within_code=1                       # now we're within an escape code
            continue
        fi
        output+="${char}"                       # if none of the above applies, add current character to output
    done
    eval "$2=\"${output}\""                     # assign output to target variable
}
while read -r line; do
    strip_escape_codes "${line}" stripped
    echo "${stripped}"
done
