$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 3 teeth on 54 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 54;        // sector angle, degrees
root_r = 50;              // root circle radius
tooth_h = 5;              // tooth height over the root circle
teeth = 3;                // number of teeth on the sector
hub_r = 12;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[33.858, 0], [34.878, 2.124], [35.797, 4.294], [41.343, 4.885], [42.788, 9.861], [38.422, 13.331], [38.809, 15.655], [39.086, 17.995], [44.247, 20.109], [44.247, 25.291], [39.086, 27.405], [38.809, 29.745], [38.422, 32.069], [42.788, 35.539], [41.343, 40.515], [35.797, 41.106], [34.878, 43.276], [33.858, 45.4], [0, 28.148], [0.271, 27.581], [0.511, 27], [0.721, 26.408], [0.899, 25.806], [1.046, 25.195], [1.16, 24.577], [1.242, 23.954], [1.292, 23.328], [1.308, 22.7], [1.292, 22.072], [1.242, 21.446], [1.16, 20.823], [1.046, 20.205], [0.899, 19.594], [0.721, 18.992], [0.511, 18.4], [0.271, 17.819], [0, 17.252]];  // primary outline, 37 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
