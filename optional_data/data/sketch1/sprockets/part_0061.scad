$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[39.528, 19.133], [43.551, 25.006], [38.257, 29.195], [38.466, 36.311], [31.747, 36.973], [28.076, 43.073], [22.066, 39.997], [15.68, 43.144], [12.287, 37.307], [5.214, 36.501], [5.515, 29.757], [0, 25.255], [3.9, 19.744], [1.694, 12.975], [7.954, 10.447], [9.758, 3.56], [16.391, 4.818], [21.632, 0], [26.532, 4.644], [33.546, 3.424], [35.157, 9.981], [41.717, 12.746]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
