$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 11 teeth, 18 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[41.506, 21.133], [47.511, 27.279], [40.235, 31.195], [41.963, 39.612], [33.725, 38.973], [30.629, 46.988], [24.044, 41.997], [17.106, 47.066], [14.265, 39.307], [5.688, 39.82], [7.493, 31.757], [0, 27.551], [5.878, 21.744], [1.848, 14.155], [9.932, 12.447], [10.645, 3.884], [18.369, 6.818], [23.599, 0], [28.51, 6.644], [36.596, 3.736], [37.135, 11.981], [45.51, 13.905]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
