# min - An eBook Publishing Service  

Finely handcrafted eBooks available here.  

## Description  

This project provides a simple workflow for generating ePub files from Markdown content.  

### File Structure  

- **`books/`** – Directory containing finished eBooks.  
- **`fonts/`** – Custom fonts that can be used for eBook generation.  
- **`wip/`** – Working directory for projects in progress.  
  - **`wip/style.css`** – Defines the styles used in the generated eBooks.  
  - **`wip/generate.sh`** – Script that compiles a `.epub` file from a Markdown file.  

### Usage  

#### Basic ePub Generation  

To generate an `.epub` from the `content.md` file inside a project directory, navigate to the respective folder and run:  

```sh
cd wip/ttk/
../generate-epub.sh
```

#### Custom ePub Generation  

For more control, specify all required parameters in order:  

```sh
./generate-epub.sh my_content.md my_output.epub my_metadata.yaml my_cover.jpg
```

⚠️ **Important:** The script requires all four parameters in the correct order to function properly.  

- **`my_content.md`** – The source Markdown file.  
- **`my_output.epub`** – The name of the generated ePub file.  
- **`my_metadata.yaml`** – Metadata file containing additional eBook details.  
- **`my_cover.jpg`** – Cover image for the eBook.  