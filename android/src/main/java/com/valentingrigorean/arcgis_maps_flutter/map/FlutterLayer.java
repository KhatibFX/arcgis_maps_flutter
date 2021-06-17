package com.valentingrigorean.arcgis_maps_flutter.map;

import com.esri.arcgisruntime.data.ServiceFeatureTable;
import com.esri.arcgisruntime.io.RemoteResource;
import com.esri.arcgisruntime.layers.ArcGISTiledLayer;
import com.esri.arcgisruntime.layers.ArcGISVectorTiledLayer;
import com.esri.arcgisruntime.layers.FeatureLayer;
import com.esri.arcgisruntime.layers.Layer;
import com.esri.arcgisruntime.security.Credential;
import com.valentingrigorean.arcgis_maps_flutter.Convert;

import java.util.Map;
import java.util.Objects;

public class FlutterLayer {

    private final String layerId;
    private final String layerType;
    private final String url;
    private final Credential credential;


    public FlutterLayer(Map<?, ?> data) {
        layerId = (String) data.get("layerId");
        layerType = (String) data.get("layerType");
        url = (String) data.get("url");
        if (data.containsKey("credential")) {
            credential = Convert.toCredentials(data.get("credential"));
        } else {
            credential = null;
        }
    }

    public String getLayerId() {
        return layerId;
    }


    public Layer createLayer() {
        Layer layer;
        RemoteResource remoteResource;
        switch (layerType) {
            case "VectorTileLayer":
                ArcGISVectorTiledLayer vectorTiledLayer = new ArcGISVectorTiledLayer(url);
                layer = vectorTiledLayer;
                remoteResource = vectorTiledLayer;
                break;
            case "FeatureLayer":
                ServiceFeatureTable serviceFeatureTable = new ServiceFeatureTable(url);
                remoteResource = serviceFeatureTable;
                layer = new FeatureLayer(serviceFeatureTable);
                break;
            case "TiledLayer":
                ArcGISTiledLayer tiledLayer = new ArcGISTiledLayer(url);
                remoteResource = tiledLayer;
                layer = tiledLayer;
                break;
            default:
                throw new UnsupportedOperationException("not implemented.");
        }

        if (credential != null && remoteResource != null) {
            remoteResource.setCredential(credential);
        }
        return layer;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        FlutterLayer that = (FlutterLayer) o;
        return Objects.equals(layerId, that.layerId) &&
                Objects.equals(layerType, that.layerType) &&
                Objects.equals(url, that.url) &&
                Objects.equals(credential, that.credential);
    }

    @Override
    public int hashCode() {
        return Objects.hash(layerId, layerType, url, credential);
    }
}
