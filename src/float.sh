#!/bin/bash
# Some code from: http://www.linuxjournal.com/content/floating-point-math-bash
# Example:
#   float_eval '12.0 / 3.0'
#  if float_cond '10.0 > 9.0'; then
#    echo 'As expected, 10.0 is greater than 9.0'
#  fi
#  a=12.0
#  b=3.0
#  c=$(float_eval "$a / $b")
#####################################################################

# Floating point number functions.

#####################################################################
# Default scale used by float functions.

float_scale=2


#####################################################################
# Evaluate a floating point number expression.

function float_eval()
{
    local stat=0
    local result=0.0
    if [[ $# -gt 0 ]]; then
        result=$(echo "scale=$float_scale; $*" | bc -q 2>/dev/null)
        stat=$?
        if [[ $stat -eq 0  &&  -z "$result" ]]; then stat=1; fi
    fi
    echo $result
    return $stat
}


#####################################################################
# Evaluate a floating point number conditional expression.

function float_cond()
{
    local cond=0
    if [[ $# -gt 0 ]]; then
        cond=$(echo "$*" | bc -q 2>/dev/null)
        if [[ -z "$cond" ]]; then cond=0; fi
        if [[ "$cond" != 0  &&  "$cond" != 1 ]]; then cond=0; fi
    fi
    local stat=$((cond == 0))
    return $stat
}

# vim: tabstop=4: shiftwidth=4: noexpandtab:
# kate: tab-width 4; indent-width 4; replace-tabs false;
