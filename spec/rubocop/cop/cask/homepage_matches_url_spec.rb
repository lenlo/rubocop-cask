describe RuboCop::Cop::Cask::HomepageMatchesUrl do
  include CopSharedExamples

  subject(:cop) { described_class.new }
  let(:missing_line_msg) do
    'stanza groups should be separated by a single empty line'
  end
  let(:extra_line_msg) do
    'stanzas within the same group should have no lines between them'
  end

  context 'when the url matches the homepage' do
    context 'and there is no comment' do
      let(:source) do
        <<-CASK.undent
          cask 'foo' do
            url 'https://foo.example.com/foo.zip'
            homepage 'https://foo.example.com'
          end
        CASK
      end

      include_examples 'does not report any offenses'
    end

    context 'and the url stanza has a referrer' do
      context 'and no interpolation' do
        let(:source) do
          <<-CASK.undent
            cask 'foo' do
              url 'https://foo.example.com/foo.zip',
                  referrer: 'https://example.com/foo/'
              homepage 'https://foo.example.com'
            end
          CASK
        end

        include_examples 'does not report any offenses'
      end

      context 'and interpolation' do
        let(:source) do
          <<-CASK.undent
            cask 'foo' do
              version '1.8.0_72,8.13.0.5'
              url "https://foo.example.com/foo-\#{version.after_comma}-\#{version.minor}.\#{version.patch}.\#{version.before_comma.sub(\%r{.*_}, '')}.zip",
                  referrer: 'https://example.com/foo/'
              homepage 'https://foo.example.com'
            end
          CASK
        end

        include_examples 'does not report any offenses'
      end
    end

    context 'but there is a comment' do
      context 'which does not match the url' do
        let(:source) do
          <<-CASK.undent
            cask 'foo' do
              # this is just a comment with information
              url 'https://example.com/foo.zip'
              homepage 'https://example.com'
            end
          CASK
        end

        include_examples 'does not report any offenses'
      end

      context 'which matches the url' do
        let(:source) do
          <<-CASK.undent
            cask 'foo' do
              # foo.example.com was verified as official when first introduced to the cask
              url 'https://foo.example.com/foo.zip'
              homepage 'https://foo.example.com'
            end
          CASK
        end
        let(:expected_offenses) do
          [{
            message: '`foo.example.com` matches `example.com`, ' \
                     'the comment above the `url` stanza is unnecessary',
            severity: :convention,
            line: 2,
            column: 2,
            source: '# foo.example.com was verified as official when ' \
                    'first introduced to the cask'
          }]
        end

        include_examples 'reports offenses'
      end
    end
  end

  context 'when the url does not match the homepage' do
    context 'and there is a comment' do
      context 'which matches the url' do
        context 'and does not have slashes' do
          let(:source) do
            <<-CASK.undent
              cask 'foo' do
                # example.com was verified as official when first introduced to the cask
                url 'https://example.com/foo.zip'
                homepage 'https://foo.example.org'
              end
            CASK
          end

          include_examples 'does not report any offenses'
        end

        context 'and has slashes' do
          let(:source) do
            <<-CASK.undent
              cask 'foo' do
                # example.com/vendor/app was verified as official when first introduced to the cask
                url 'https://downloads.example.com/vendor/app/foo.zip'
                homepage 'https://vendor.example.org/app/'
              end
            CASK
          end

          include_examples 'does not report any offenses'
        end
      end

      context 'which does not match the url' do
        let(:source) do
          <<-CASK.undent
            cask 'foo' do
              # example.com was verified as official when first introduced to the cask
              url 'https://example.org/foo.zip'
              homepage 'https://foo.example.com'
            end
          CASK
        end
        let(:expected_offenses) do
          [{
            message: '`example.com` does not match `example.org/foo.zip`',
            severity: :convention,
            line: 2,
            column: 2,
            source: '# example.com was verified as official when ' \
                    'first introduced to the cask'
          }]
        end

        include_examples 'reports offenses'
      end
    end

    context 'but the comment is missing' do
      let(:source) do
        <<-CASK.undent
          cask 'foo' do
            url 'https://example.com/foo.zip'
            homepage 'https://example.org'
          end
        CASK
      end
      let(:expected_offenses) do
        [{
          message: '`example.com` does not match `example.org`, a ' \
                   'comment in the form of `# example.com was verified as ' \
                   'official when first introduced to the cask` has to be ' \
                   'added above the `url` stanza',
          severity: :convention,
          line: 2,
          column: 2,
          source: "url 'https://example.com/foo.zip'"
        }]
      end

      include_examples 'reports offenses'
    end
  end
end