$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 14 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[31.623, 15.77], [35.633, 20.46], [30.634, 23.596], [31.472, 29.709], [25.572, 29.646], [22.972, 35.241], [18.042, 31.998], [12.829, 35.299], [10.436, 29.905], [4.266, 29.865], [5.169, 24.033], [0, 20.663], [3.912, 16.245], [1.386, 10.616], [7.066, 9.014], [7.984, 2.913], [13.628, 4.636], [17.699, 0], [21.515, 4.501], [27.447, 2.802], [28.224, 8.652], [34.132, 10.429]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
