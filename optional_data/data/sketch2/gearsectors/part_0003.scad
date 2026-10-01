$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 70;              // root circle radius
tooth_h = 6;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 6;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[51.678, 0], [53.106, 2.973], [54.392, 6.01], [61.21, 7.161], [63.208, 14.037], [58.068, 18.662], [58.61, 21.916], [58.997, 25.191], [65.224, 28.199], [65.224, 35.359], [58.997, 38.367], [58.61, 41.642], [58.068, 44.896], [63.208, 49.521], [61.21, 56.397], [54.392, 57.548], [53.106, 60.585], [51.678, 63.558], [0, 37.227], [0.271, 36.66], [0.511, 36.079], [0.721, 35.487], [0.899, 34.885], [1.046, 34.274], [1.16, 33.656], [1.242, 33.033], [1.292, 32.407], [1.308, 31.779], [1.292, 31.151], [1.242, 30.525], [1.16, 29.902], [1.046, 29.284], [0.899, 28.673], [0.721, 28.071], [0.511, 27.479], [0.271, 26.898], [0, 26.331]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
