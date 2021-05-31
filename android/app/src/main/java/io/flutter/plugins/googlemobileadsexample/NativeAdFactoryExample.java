package io.flutter.plugins.googlemobileadsexample;

import android.graphics.Color;
import android.view.LayoutInflater;
import android.widget.TextView;
import com.google.android.gms.ads.nativead.NativeAd;
import com.google.android.gms.ads.nativead.NativeAdView;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;
import java.util.Map;

class NativeAdFactoryExample implements NativeAdFactory {
    private final LayoutInflater layoutInflater;

    NativeAdFactoryExample(LayoutInflater layoutInflater) {
        this.layoutInflater = layoutInflater;
    }

    @Override
    public NativeAdView createNativeAd(NativeAd nativeAd, Map<String, Object> customOptions) {
        final NativeAdView adView = (NativeAdView) layoutInflater.inflate(com.Handrange.R.layout.my_native_ad, null);
        final TextView headlineView = adView.findViewById(com.Handrange.R.id.ad_headline);
        final TextView bodyView = adView.findViewById(com.Handrange.R.id.ad_body);

        headlineView.setText(nativeAd.getHeadline());
        bodyView.setText(nativeAd.getBody());

        adView.setBackgroundColor(Color.YELLOW);

        adView.setNativeAd(nativeAd);
        adView.setBodyView(bodyView);
        adView.setHeadlineView(headlineView);
        return adView;
    }
}
