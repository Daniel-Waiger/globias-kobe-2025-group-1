// ImageJ Macro to Calculate Volume Delta Between Two CSV Files
// This macro compares volume columns from original and subtracted CSV files

// Let user select the original CSV file
originalFile = File.openDialog("Select the ORIGINAL CSV file");
if (originalFile == "") {
    exit("No original file selected");
}

// Let user select the subtracted CSV file
subtractedFile = File.openDialog("Select the SUBTRACTED CSV file");
if (subtractedFile == "") {
    exit("No subtracted file selected");
}

// Get directory from original file to save output
dir = File.getParent(originalFile) + File.separator;
outputFile = dir + "volume_delta_results.csv";

// Check if files exist
if (!File.exists(originalFile)) {
    exit("Original file not found: " + originalFile);
}
if (!File.exists(subtractedFile)) {
    exit("Subtracted file not found: " + subtractedFile);
}

// Read original CSV file
print("Reading original file...");
originalLines = split(File.openAsString(originalFile), "\n");
originalHeader = originalLines[0];

// Read subtracted CSV file
print("Reading subtracted file...");
subtractedLines = split(File.openAsString(subtractedFile), "\n");

// Check if both files have the same number of rows
if (originalLines.length != subtractedLines.length) {
    exit("Error: Files have different number of rows!");
}

// Create output content with new header in the specified order
outputContent = "Label,VoxelCount,Volume,Subtracted_Volume,Volume_Delta,Centroid.X,Centroid.Y,Centroid.Z\n";

// Initialize counter for positive volume deltas
positiveCount = 0;
totalProcessed = 0;

// Process each data row (skip header)
for (i = 1; i < originalLines.length; i++) {
    if (originalLines[i] == "" || subtractedLines[i] == "") continue; // Skip empty lines
    
    // Parse original row
    originalCols = split(originalLines[i], ",");
    if (originalCols.length < 6) continue; // Skip if not enough columns
    
    // Parse subtracted row
    subtractedCols = split(subtractedLines[i], ",");
    if (subtractedCols.length < 3) continue; // Skip if not enough columns
    
    // Extract volume values (column index 2, which is the 3rd column)
    originalVolume = parseFloat(originalCols[2]);
    subtractedVolume = parseFloat(subtractedCols[2]);
    
    // Calculate delta (original - subtracted)
    volumeDelta = originalVolume - subtractedVolume;
    
    // Count positive deltas
    if (volumeDelta > 0) {
        positiveCount++;
    }
    totalProcessed++;
    
    // Build row in the new column order: Label,VoxelCount,Volume,Subtracted_Volume,Volume_Delta,Centroid.X,Centroid.Y,Centroid.Z
    newRow = originalCols[0] + "," + originalCols[1] + "," + originalCols[2] + "," + subtractedVolume + "," + volumeDelta + "," + originalCols[3] + "," + originalCols[4] + "," + originalCols[5];
    outputContent = outputContent + newRow + "\n";
}

// Save the result
File.saveString(outputContent, outputFile);

print("Volume delta calculation complete!");
print("Results saved to: " + outputFile);
print("Total rows processed: " + totalProcessed);
print("Rows with positive volume delta (> 0): " + positiveCount);
print("Percentage with positive delta: " + (positiveCount * 100.0 / totalProcessed) + "%");