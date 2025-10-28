# ImageJ Volume Delta Calculator

A simple ImageJ macro that calculates the volume difference between two CSV files containing morphological analysis data.

## Description

This macro compares volume measurements from two CSV files (typically representing original and subtracted states) and calculates the delta (difference) between corresponding volume values. The result is saved as a new CSV file with an additional "Volume_Delta" column.

## Files

- `Volume_Delta_Calculator.ijm` - The main ImageJ macro
- Sample CSV files with morphological analysis data

## Usage

1. **Open ImageJ/Fiji**
2. **Run the macro**: Go to `Plugins → Macros → Run...` and select `Volume_Delta_Calculator.ijm`
3. **Select files**:
   - First dialog: Choose your **original/baseline CSV file**
   - Second dialog: Choose your **subtracted CSV file**
4. **Results**: The macro will create `volume_delta_results.csv` in the same directory as your original file

## CSV File Requirements

Your CSV files should contain:
- A header row
- A "Volume" column (3rd column)
- Matching number of rows between both files

Example CSV structure:
```
Label,VoxelCount,Volume,Centroid.X,Centroid.Y,Centroid.Z
1,30364,30364,506.142,137.317,11.454
2,28139,28139,548.209,157.526,13.022
...
```

## Output

The macro generates a new CSV file with:
- All original columns from the first file
- An additional "Volume_Delta" column showing the difference (Original - Subtracted)

## Features

- User-friendly file selection dialogs
- Error checking for file existence and row count matching
- Automatic output file naming and location
- Handles empty lines gracefully

## Requirements

- ImageJ or Fiji
- Two CSV files with volume data

## License

This project is provided as-is for research and analysis purposes.