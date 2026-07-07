return {
    image = "{{image}}",
<* for name, value in colors *>
    {{name}} = "{{value.dark.hex}}",
<* endfor *>
}
