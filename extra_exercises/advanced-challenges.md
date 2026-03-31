# Advanced Challenges

These optional exercises are for learners who finish early and want to strengthen workflow design habits used in real bioinformatics pipelines. Try each task first, then compare with the reference solution.

## 1. Safety First (Validation)

### Task
Modify `countreads` so it validates that the input is FASTQ-like before counting. Specifically, check that the first character of the file is `@`. If validation fails, the rule must stop with a non-zero exit code and an error message.

### Solution
<details>
<summary>Show solution</summary>

```snakemake
rule countreads:
    output: "{indir}.{myfile}.fq.count"
    input:  "{indir}/{myfile}.fq"
    shell:
        """
        first_char=$(head -c 1 {input})
        if [ "$first_char" != "@" ]; then
            echo "ERROR: {input} does not look like FASTQ (first character is not @)." >&2
            exit 1
        fi
        echo $(( $(wc -l < {input}) / 4 )) > {output}
        """
```

Run this rule on all requested count targets:

```bash
snakemake -j1 -F -p
```

Or run one specific output target:

```bash
snakemake -j1 -F -p reads.ref1_1.fq.count
```

</details>

### Why this matters
This is robust shell scripting inside Snakemake rules. Early validation gives faster, clearer failures and prevents bad inputs from propagating through the DAG.

## 2. Efficiency (Threads)

### Task
Add `threads: 4` to `trimreads`. Update the shell command to use `{threads}` and explain how to run Snakemake with `--cores` so it can schedule threaded jobs correctly.

### Solution
<details>
<summary>Show solution</summary>

```snakemake
rule trimreads:
    output: "trimmed/{myfile}.fq"
    input:  "reads/{myfile}.fq"
    threads: 4
    shell:
        """
        echo "Snakemake allocated {threads} threads for this job" >&2
        seqtk trimfq -q 0.05 {input} | seqtk seq -L 60 - > {output}
        """
```

Run with enough global cores for scheduling, for example:

```bash
snakemake -j8 -F -p
```

To run one sample target explicitly:

```bash
snakemake -j1 -F -p trimmed/ref1_1.fq
```

Snakemake now knows each `trimreads` job requests 4 threads, so with `-j8` it can run up to two such jobs at once if the DAG allows it.
Even when a specific command is mostly single-threaded, `threads` is still valuable scheduler metadata for planning concurrent jobs.

</details>

### Why this matters
`threads` makes resource needs explicit, helping Snakemake optimize DAG execution and avoid overcommitting CPU resources.

## 3. Bioinformatics (Params)

### Task
Replace fixed trimming settings with parameterized quality trimming using `seqtk trimfq -q 0.05`. Add a `params` block that defines:

- a quality threshold
- a minimum read length filter set to 80% of the original read length

### Solution
<details>
<summary>Show solution</summary>

```snakemake
rule trimreads:
    output: "trimmed/{myfile}.fq"
    input:  "reads/{myfile}.fq"
    params:
        q = 0.05,
        min_fraction = 0.8
    shell:
        r'''
        read_len=$(sed -n '2p' {input} | tr -d '\n' | wc -c)
        min_len=$(python -c "print(int($read_len * {params.min_fraction}))")
        seqtk trimfq -q {params.q} {input} | seqtk seq -L "$min_len" - > {output}
        '''
```

This reads the first sequence line in the FASTQ, computes 80% of that length via `params.min_fraction`, then keeps reads with trimmed length at least that threshold.

Run the updated trimming workflow:

```bash
snakemake -j4 -F -p
```

Or run a specific trimmed file target:

```bash
snakemake -j1 -F -p trimmed/temp33_1_1.fq
```

</details>

### Why this matters
`params` separates tunable analysis settings from command structure. That improves reproducibility, readability, and makes experiments easier when thresholds change.
