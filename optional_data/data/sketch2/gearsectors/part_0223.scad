$fn = 32;

// ----------------------------------------------------------------------
// Gear sector: 2 teeth on 42 degrees
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sector_angle = 42;        // sector angle, degrees
root_r = 60;              // root circle radius
tooth_h = 7;              // tooth height over the root circle
teeth = 2;                // number of teeth on the sector
hub_r = 10;               // hub bore radius
plate_t = 5;              // sector thickness, Z
arc_step = 3;             // sampling step of the root/hub arcs, degrees

tip_r = root_r + tooth_h;  // tip circle radius

profile = [[46.679, 0], [47.662, 2.762], [48.51, 5.569], [56.138, 7.286], [57.303, 14.557], [50.592, 18.571], [50.664, 21.502], [50.592, 24.433], [57.303, 28.447], [56.138, 35.718], [48.51, 37.435], [47.662, 40.242], [46.679, 43.004], [0, 25.086], [0.175, 24.592], [0.323, 24.09], [0.445, 23.581], [0.541, 23.066], [0.609, 22.547], [0.65, 22.025], [0.664, 21.502], [0.65, 20.979], [0.609, 20.457], [0.541, 19.938], [0.445, 19.423], [0.323, 18.914], [0.175, 18.412], [0, 17.918]];  // primary outline, 28 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = plate_t) polygon(points = profile);
