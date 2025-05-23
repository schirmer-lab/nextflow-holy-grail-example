process DOWNLOAD_SCRIPT {
    tag "${script_url}"
    publishDir "results/download"

    input:
    val script_url
    val html_script_name

    output:
    path "${html_script_name}.html"

    script:
    """
    bash ${baseDir}/bin/download_holy_script.sh "${script_url}" "${html_script_name}.html"
    """
}

process CLEAN_SCRIPT {
    tag "${html_script_path}"
    publishDir "results/clean"

    input:
    path html_script_path
    val clean_script_name

    output:
    path "${clean_script_name}.txt"

    script:
    """
    python3 ${baseDir}/bin/clean_html_script.py "${html_script_path}" "${clean_script_name}.txt"
    """
}

process PICK_RANDOM_LINE {
    tag "${clean_script_path}"
    publishDir "results/quote"

    input:
    path clean_script_path
    val quote_file_name
    val min_words

    output:
    stdout

    script:
    """
    python3 ${baseDir}/bin/pick_random_line.py "${clean_script_path}" ${min_words}
    """
}
