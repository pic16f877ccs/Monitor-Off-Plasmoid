/*
 * Copyright (C) 2023 by pic16f877ccs
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation;
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>
 */
import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id : root

    property Component compactRepr: CompactRepresentation {}
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground
    Plasmoid.compactRepresentation: compactRepr
    Plasmoid.fullRepresentation: Plasmoid.compactRepresentation
}
